type t = {
  src,
  credit: option(credit),
  titleBgColor,
}
and src
and credit = {
  text: string,
  url: option(ReactRouter.path),
}
and titleBgColor =
  | Blue
  | Orange;

[@bs.get] external srcset: src => string = "srcset";
[@bs.get] external fallback: src => string = "fallback";
[@bs.get] external placeholder: src => string = "placeholder";
