module Css = MarkdownStyles;

[@react.component]
let make = (~children) => {
  <div className=Css.markdown> children </div>;
};

module Row = {
  [@react.component]
  let make = (~className, ~children) => {
    <div className={Cn.make([Css.row, className])}> <div /> children </div>;
  };
};

module ExpandedRow = {
  [@react.component]
  let make = (~className, ~children) => {
    <div className={Cn.make([Css.expandedRow, className])}> children </div>;
  };
};

module RowWithSidenoteText = {
  [@react.component]
  let make = (~text, ~className, ~children) => {
    <div className={Cn.make([Css.row, Css.rowWithSidenote, className])}>
      <Layout.SecondarySidenote> text->React.string </Layout.SecondarySidenote>
      children
    </div>;
  };
};

module RowWithSidenoteIcon = {
  [@react.component]
  let make = (~icon: (module Icon.Component), ~className, ~children) => {
    let (module Icon) = icon;
    <div className={Cn.make([Css.row, Css.rowWithSidenote, className])}>
      <Layout.SecondarySidenote>
        <Icon size=MD color=Gray />
      </Layout.SecondarySidenote>
      children
    </div>;
  };
};

module H1 = {
  [@react.component]
  let make = (~children) => {
    <h1 className=Css.h1> children </h1>;
  };
};

module H2 = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteText text="##" className=Css.h2Row>
      <h2 className=Css.h2> children </h2>
    </RowWithSidenoteText>;
  };
};

module H3 = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteText text="###" className=Css.h3Row>
      <h3 className=Css.h3> children </h3>
    </RowWithSidenoteText>;
  };
};

module H4 = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteText text="####" className=Css.h4Row>
      <h4 className=Css.h4> children </h4>
    </RowWithSidenoteText>;
  };
};

module P = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.pRow> <p className=Css.p> children </p> </Row>;
  };
};

module A = {
  [@react.component]
  let make = (~href, ~children) => {
    <A href target=Blank underline=Always> children </A>;
  };
};

module InternalLink = {
  [@react.component]
  let make = (~path, ~children) => {
    <Link path underline=Always> children </Link>;
  };
};

module Ol = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.listRow>
      <ol className={Cn.make([Css.list, Css.ol])}> children </ol>
    </Row>;
  };
};

module Ul = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.listRow>
      <ul className={Cn.make([Css.list, Css.ul])}> children </ul>
    </Row>;
  };
};

module Li = {
  [@react.component]
  let make = (~children) => {
    <li className=Css.li> children </li>;
  };
};

module Hr = {
  [@react.component]
  let make = () => {
    <Row className=Css.hrRow> <hr className=Css.hr /> </Row>;
  };
};

module Pre = {
  [@react.component]
  let make = (~children) => {
    <ExpandedRow className=Css.codeRow>
      <pre className=Css.pre> children </pre>
    </ExpandedRow>;
  };
};

module Code = {
  let filePragma = "// @file: ";
  let indexOfFirstFileNameChar = filePragma->Js.String2.indexOf(":") + 2;
  let languageRegExp = [%bs.re "/language-/"];

  [@react.component]
  let make = (~className, ~children as source) => {
    let language =
      React.useMemo0(() =>
        className->Option.map(cn => {
          let language = cn->Js.String.replaceByRe(languageRegExp, "", _);
          let label =
            switch (language) {
            | "reason" => "re"
            | _ => language
            };
          (language, label);
        })
      );
    let (source, file) =
      React.useMemo0(() =>
        if (source->Js.String2.startsWith(filePragma)) {
          let indexOfFirstCodeChar =
            switch (source->Js.String2.indexOf("\n")) {
            | (-1) => None
            | _ as x =>
              switch (source->Js.String2.charAt(x + 1)) {
              | "\n" => Some(x + 2)
              | _ => Some(x + 1)
              }
            };

          switch (indexOfFirstCodeChar) {
          | None => (source, None)
          | Some(x) =>
            let trimmedSource = source->Js.String2.sliceToEnd(~from=x);
            let file =
              source
              ->Js.String2.slice(~from=indexOfFirstFileNameChar, ~to_=x)
              ->Js.String2.trim;
            (trimmedSource, Some(file));
          };
        } else {
          (source, None);
        }
      );
    let code =
      React.useMemo0(() =>
        switch (language) {
        | Some((language, _)) =>
          Prism.(source->highlight(language->Language.get, language))
        | None => source
        }
      );

    <>
      {switch (language, file) {
       | (Some((_, label)), None) =>
         <div
           className={Cn.make([
             Css.codeLabelsRow,
             Css.codeLabelsRowWithoutFile,
           ])}>
           <div className={Cn.make([Css.codeLabel, Css.languageLabel])}>
             label->React.string
           </div>
         </div>
       | (Some((_, label)), Some(file)) =>
         <div
           className={Cn.make([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
           <div className={Cn.make([Css.codeLabel, Css.fileLabel])}>
             file->React.string
           </div>
           <div className={Cn.make([Css.codeLabel, Css.languageLabel])}>
             label->React.string
           </div>
         </div>
       | (None, Some(file)) =>
         <div
           className={Cn.make([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
           <div className={Cn.make([Css.codeLabel, Css.fileLabel])}>
             file->React.string
           </div>
         </div>
       | (None, None) => React.null
       }}
      <code className=Css.code dangerouslySetInnerHTML={"__html": code} />
    </>;
  };
};

module InlineCode = {
  [@react.component]
  let make = (~children) => {
    <code className=Css.inlineCode> children </code>;
  };
};

module Note = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteIcon icon=(module InfoIcon) className=Css.noteRow>
      <div className=Css.note> children </div>
    </RowWithSidenoteIcon>;
  };
};

module Highlight = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.highlightRow>
      <div className=Css.highlight> children </div>
    </Row>;
  };
};

module CoverImage = {
  [@react.component]
  let make = (~src, ~credit) => {
    <ExpandedRow className=Css.coverImageRow>
      <figure className=Css.coverImageFigure>
        <img src className=Css.coverImage />
        {switch (credit) {
         | Some(credit) =>
           <figcaption className=Css.coverImageCredit>
             "Artwork: "->React.string
             <A href={credit##url}> {credit##text->React.string} </A>
           </figcaption>
         | None => React.null
         }}
      </figure>
    </ExpandedRow>;
  };
};

module InlineImage = {
  [@react.component]
  let make = (~src, ~caption) => {
    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <img src alt=?caption className=Css.inlineImage />
        {switch (caption) {
         | Some(caption) =>
           <figcaption className=Css.inlineImageCaption>
             caption->React.string
           </figcaption>
         | None => React.null
         }}
      </figure>
    </Row>;
  };
};

module AnimatedGif = {
  [@react.component]
  let make = (~src, ~caption) => {
    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <img src alt=?caption className=Css.inlineImage />
        {switch (caption) {
         | Some(caption) =>
           <figcaption className=Css.inlineImageCaption>
             caption->React.string
           </figcaption>
         | None => React.null
         }}
      </figure>
    </Row>;
  };
};

module Expandable = {
  type action =
    | Toggle;

  let reducer = (state, action) =>
    switch (state, action) {
    | (`Expanded, Toggle) => `Collapsed
    | (`Collapsed, Toggle) => `Expanded
    };

  [@react.component]
  let make = (~label: string, ~children) => {
    let (state, dispatch) = reducer->React.useReducer(`Collapsed);

    <>
      <RowWithSidenoteIcon icon=(module TipIcon) className=Css.expandableRow>
        <Control onClick={_ => Toggle->dispatch}>
          <div className=Css.expandableTrigger>
            <span className=Css.expandableTriggerText>
              label->React.string
            </span>
            <CaretIcon
              size=MD
              color=Gray
              className={Cn.make([
                Css.expandableTriggerIcon,
                switch (state) {
                | `Collapsed => Css.expandableTriggerIconCollapsed
                | `Expanded => Css.expandableTriggerIconExpanded
                },
              ])}
            />
          </div>
        </Control>
      </RowWithSidenoteIcon>
      {switch (state) {
       | `Collapsed => React.null
       | `Expanded => <> children <Hr /> </>
       }}
    </>;
  };
};

// Exports to JS
let h1 = H1.make;
let h2 = H2.make;
let h3 = H3.make;
let h4 = H4.make;
let p = P.make;
let a = A.make;
let ol = Ol.make;
let ul = Ul.make;
let li = Li.make;
let hr = Hr.make;
let pre = Pre.make;
let code = Code.make;
let inlineCode = InlineCode.make;

let coverImage = CoverImage.make;
let inlineImage = InlineImage.make;
let animatedGif = AnimatedGif.make;
let internalLink = InternalLink.make;
let note = Note.make;
let expandable = Expandable.make;
let highlight = Highlight.make;

// MDXProvider components
let components = {
  "h1": h1,
  "h2": h2,
  "h3": h3,
  "h4": h4,
  "p": p,
  "a": a,
  "ol": ol,
  "ul": ul,
  "li": li,
  "hr": hr,
  "pre": pre,
  "code": code,
  "inlineCode": inlineCode,
};
