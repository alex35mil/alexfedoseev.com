module Date: {
  type t
  let year: t => string
  let parse: string => t
  let format: t => string
} = {
  type rec t = {year: int, month: month, day: int}
  and month = [#1 | #2 | #3 | #4 | #5 | #6 | #7 | #8 | #9 | #10 | #11 | #12]

  let year = date => date.year->Int.toString

  let month = date =>
    switch date.month {
    | #1 => "Jan"
    | #2 => "Feb"
    | #3 => "Mar"
    | #4 => "Apr"
    | #5 => "May"
    | #6 => "Jun"
    | #7 => "Jul"
    | #8 => "Aug"
    | #9 => "Sep"
    | #10 => "Oct"
    | #11 => "Nov"
    | #12 => "Dec"
    }

  let parse = date => {
    switch date->Js.String2.split("-") {
    | [year, month, day] =>
      switch (year->Int.fromString, month->Int.fromString, day->Int.fromString) {
      | (Some(year), Some(month), Some(day)) =>
        let month = switch month {
        | 1 => #1
        | 2 => #2
        | 3 => #3
        | 4 => #4
        | 5 => #5
        | 6 => #6
        | 7 => #7
        | 8 => #8
        | 9 => #9
        | 10 => #10
        | 11 => #11
        | 12 => #12
        | _ => failwith(`Invalid month in blog post file name: ${date}`)
        }

        {
          year: year,
          month: month,
          day: day,
        }
      | _ => failwith(`Invalid date in blog post file name: ${date}`)
      }
    | _ => failwith(`Invalid date in blog post file name: ${date}`)
    }
  }

  let format = date => {
    let year = date->year
    let month = date->month
    let day = date.day->Int.toString
    `${day} ${month}, ${year}`
  }
}

type date = Date.t

module Category = {
  type t =
    | Dev
    | Travel
    | Productivity

  let all = [Dev, Travel, Productivity]

  let format = x =>
    switch x {
    | Dev => "Dev"
    | Travel => "Travel"
    | Productivity => "Productivity"
    }

  let formatForUrl = x =>
    switch x {
    | Dev => "dev"
    | Travel => "travel"
    | Productivity => "productivity"
    }

  let fromFormatted = x =>
    switch x {
    | "Dev" => Ok(Dev)
    | "Travel" => Ok(Travel)
    | "Productivity" => Ok(Productivity)
    | _ => Error()
    }

  let fromUrl = x =>
    switch x {
    | "dev" => Ok(Dev)
    | "travel" => Ok(Travel)
    | "productivity" => Ok(Productivity)
    | _ => Error()
    }
}

type category = Category.t

module Cover = {
  type rec t = {
    src: Image.responsive<Image.postCover>,
    credit: option<credit>,
  }
  and credit = {
    text: string,
    url: option<string>,
  }
}

type cover = Cover.t

module Meta = {
  type rec t = {
    title: string,
    description: string,
    slug: string,
    category: Category.t,
    date: Date.t,
    key: string,
  }
}

type meta = Meta.t

module Dependency = {
  module Component = {
    module type t = {
      @react.component
      let make: unit => React.element
    }
  }

  type t = {
    component: module(Component.t),
    cover: option<Cover.t>,
  }
}

type dependency = Dependency.t
