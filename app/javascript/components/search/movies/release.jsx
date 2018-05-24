import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";

import PropTypes from "prop-types";

import AcceptableRelease from "./acceptable_release";
import KillerRelease from "./killer_release";
import NoAcceptableRelease from "./no_acceptable_release";

class Release extends React.Component {
  release() {
    if (this.props.has_killer_release == true) {
      return (
        <KillerRelease
          {...this.props.best_release}
          imdb_id={this.props.imdb_id}
        />
      );
    } else if (this.props.has_acceptable_release == true) {
      return (
        <AcceptableRelease
          {...this.props.best_release}
          imdb_id={this.props.imdb_id}
        />
      );
    } else {
      return <NoAcceptableRelease imdb_id={this.props.imdb_id} />;
    }
  }

  render() {
    return (
      <Row>
        <Col md={12}>
          <h3>Release information</h3>
          {this.release()}
        </Col>
      </Row>
    );
  }
}

Release.propTypes = {
  has_killer_release: PropTypes.bool,
  has_acceptable_release: PropTypes.bool,
  best_release: PropTypes.any,
  imdb_id: PropTypes.string
};

export default Release;
