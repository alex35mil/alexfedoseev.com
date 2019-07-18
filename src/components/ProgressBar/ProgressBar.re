let init = () => {
  NProgress.configure(
    ~speed=200,
    ~trickle=true,
    ~trickleSpeed=100,
    ~showSpinner=false,
    (),
  );
  NProgress.start();
};

let start = NProgress.start;
let complete = NProgress.complete;
let started = NProgress.isStarted;
