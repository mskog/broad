import React from "react";
import MomentDate from "./moment_date";
import FontAwesome from "react-fontawesome";
import PropTypes from "prop-types";

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

DownloadAt.propTypes = {
  title: PropTypes.string.isRequired
};

export default DownloadAt;
