module Array = {
  let findAndThen =
      (arr: array('a), fn: 'a => [ | `Return('b) | `Skip]): option('b) => {
    let i = 0->ref;
    let res = None->ref;
    while (i^ < arr->Array.length) {
      switch (arr->Array.getUnsafe(i^)->fn) {
      | `Skip => i := i^ + 1
      | `Return(x) =>
        res := Some(x);
        i := arr->Array.length;
      };
    };
    res^;
  };
};
