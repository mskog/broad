import React from "react";
import MomentDate from "./moment_date";
import FontAwesome from "react-fontawesome";

class DownloadAt extends React.Component {
  render() {
    return (
      <div>
        <FontAwesome name="cloud-download" />
        <MomentDate date={this.props.title} />
      </div>
    );
  }
}

export default DownloadAt;
