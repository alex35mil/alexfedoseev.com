pub type Output = anyhow::Result<Done>;

pub enum Done {
    Bye,
    Output(String),
}
