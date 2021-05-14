use std::{
    fmt,
    time::{Duration, Instant},
};

pub struct Timer {
    start: Instant,
}

impl Timer {
    pub fn start() -> Self {
        Self {
            start: Instant::now(),
        }
    }

    pub fn finish(&self) -> TimerResult {
        TimerResult::new(self.start.elapsed())
    }
}

pub struct TimerResult(Duration);

impl TimerResult {
    pub fn new(duration: Duration) -> Self {
        Self(duration)
    }
}

impl fmt::Display for TimerResult {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{:.2?}", self.0)
    }
}
