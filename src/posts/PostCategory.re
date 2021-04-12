type t =
  | Dev
  | Travel
  | Productivity;

let toString =
  fun
  | Dev => "dev"
  | Travel => "travel"
  | Productivity => "productivity";

let fromString =
  fun
  | "dev" => Ok(Dev)
  | "travel" => Ok(Travel)
  | "productivity" => Ok(Productivity)
  | _ => Error();

let (==) = (x1, x2) =>
  switch (x1, x2) {
  | (Dev, Dev)
  | (Travel, Travel)
  | (Productivity, Productivity) => true
  | _ => false
  };
