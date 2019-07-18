module Css = MarkdownStyles;

[@react.component]
let make = (~children) => {
  <div className=Css.markdown> children </div>;
};

module H1 = {
  [@react.component]
  let make = (~children) => {
    <h1 className=Css.h1> children </h1>;
  };
};

module P = {
  [@react.component]
  let make = (~children) => {
    <p className=Css.p> children </p>;
  };
};

// Exports to JS
let h1 = H1.make;
let p = P.make;

// MDXProvider components
let components = {"h1": h1, "p": p};
