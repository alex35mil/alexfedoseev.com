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
    <li> children </li>;
  };
};

module Pre = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.codeRow> <pre className=Css.pre> children </pre> </Row>;
  };
};

module Code = {
  [@react.component]
  let make = (~children) => {
    <code className=Css.code> children </code>;
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

module Image = {
  [@react.component]
  let make = (~src, ~caption) => {
    <Row className=Css.imageRow>
      <figure className=Css.imageFigure>
        <img src alt=?caption className=Css.image />
        {switch (caption) {
         | Some(caption) =>
           <figcaption className=Css.imageCaption>
             caption->React.string
           </figcaption>
         | None => React.null
         }}
      </figure>
    </Row>;
  };
};

// Exports to JS
let h1 = H1.make;
let h2 = H2.make;
let h3 = H3.make;
let p = P.make;
let a = A.make;
let ol = Ol.make;
let ul = Ul.make;
let li = Li.make;
let pre = Pre.make;
let code = Code.make;
let inlineCode = InlineCode.make;

let image = Image.make;
let note = Note.make;

// MDXProvider components
let components = {
  "h1": h1,
  "h2": h2,
  "h3": h3,
  "p": p,
  "a": a,
  "ol": ol,
  "ul": ul,
  "li": li,
  "pre": pre,
  "code": code,
  "inlineCode": inlineCode,
};
