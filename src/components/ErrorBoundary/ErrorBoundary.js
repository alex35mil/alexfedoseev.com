import React from "react";

import { make as ErrorPage } from "../../pages/ErrorPage.bs.js";

export default class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { error: false };
  }

  static getDerivedStateFromError(error) {
    return { error: true };
  }

  componentDidCatch(error, details) {
    console.error("Uh oh error", error);
    console.error("Details", details);
  }

  render() {
    if (this.state.error) {
      return <ErrorPage error={this.props.error} />;
    }

    return this.props.children;
  }
}
