type t =
  | Dev
  | Travel;

let toString =
  fun
  | Dev => "dev"
  | Travel => "travel";

let fromString =
  fun
  | "dev" => Ok(Dev)
  | "travel" => Ok(Travel)
  | _ => Error();

let (==) = (x1, x2) =>
  switch (x1, x2) {
  | (Dev, Dev)
  | (Travel, Travel) => true
  | (Dev, Travel)
  | (Travel, Dev) => false
  };
