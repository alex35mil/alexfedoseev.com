// `Sole` stands for `System of Linear Equations`
// Implementation of gaussian elimination algorithm from:
// https://rosettacode.org/wiki/Gaussian_elimination#OCaml (slightly modified)

module Array = {
  include Array
  external get: (array<'a>, int) => 'a = "%array_unsafe_get"
  external set: (array<'a>, int, 'a) => unit = "%array_unsafe_set"
  let getSafe = Array.get
  let setSafe = Array.set
}

let foldmap = (a, g, f) => {
  let n = a->Array.length
  let rec aux = (acc, i) =>
    if i >= n {
      acc
    } else {
      acc->g(a[i]->f)->aux(i->succ)
    }
  a[0]->f->aux(1)
}

let foldmapRange = ((a, b), g, f) => {
  let rec aux = (acc, n) => {
    let n = n->succ
    if n > b {
      acc
    } else {
      acc->g(n->f)->aux(n)
    }
  }
  a->f->aux(a)
}

let foldRange = ((a, b), f, init) => {
  let rec aux = (acc, n) =>
    if n > b {
      acc
    } else {
      acc->f(n)->aux(n->succ)
    }
  init->aux(a)
}

let swap = (m, i, j) => {
  let x = m[i]
  m[i] = m[j]
  m[j] = x
}

let maxTuple = (a, b) =>
  if a->snd > b->snd {
    a
  } else {
    b
  }

// Solve Ax=b for x, using gaussian elimination with scaled partial pivot,
// and then back-substitution of the resulting row-echelon matrix.
let solve = (m: array<array<float>>, b: array<float>) => {
  let n = m->Array.length
  let n' = n->pred
  let s = m->Array.map(x => x->foldmap(max, Js.Math.abs_float)) // scaling vector
  let a = {
    open Array
    makeBy(m->length, i => m[i]->concat([b[i]]))
  } // augmented matrix

  for k in 0 to n'->pred {
    // Scaled partial pivot, to preserve precision
    let pair = i => (i, a[i][k]->Js.Math.abs_float /. s[i])

    let (i_max, v) = (k, n')->foldmapRange(maxTuple, pair)

    if v < epsilon_float {
      failwith("Matrix is singular.")
    }

    a->swap(k, i_max)
    s->swap(k, i_max)

    // Eliminate one column
    for i in k->succ to n' {
      let tmp = a[i][k] /. a[k][k]
      for j in k->succ to n {
        a[i][j] = a[i][j] -. tmp *. a[k][j]
      }
    }
  }

  // Backward substitution
  let i = n'->ref
  let x = b->Array.copy
  let ok = true->ref
  while i.contents >= 0 {
    let minusDprod = (t, j) => t -. x[j] *. a[i.contents][j]
    let res =
      (i.contents + 1, n')->foldRange(minusDprod, a[i.contents][n]) /. a[i.contents][i.contents]
    if res->Js.Float.isNaN || !(res->Js.Float.isFinite) {
      ok := false
      i := -1
    } else {
      x[i.contents] = res
      i := i.contents - 1
    }
  }

  ok.contents ? Some(x) : None
}
