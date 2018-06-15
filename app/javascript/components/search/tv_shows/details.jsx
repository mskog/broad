import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import PropTypes from "prop-types";
import FontAwesome from "react-fontawesome";

import ImdbIcon from "../../imdb_icon";
import SampleButton from "./sample_button";
import CollectButton from "./collect_button";

class Details extends React.Component {
  sampleButton() {
    if (this.props.aired_episodes == 0) {
      return "";
    } else {
      return (
        <div>
          <div className="pull-left m-r-sm m-t">
            <SampleButton imdb_id={this.props.ids.imdb} />{" "}
          </div>
          <div className="pull-left m-r-sm m-t">
            <CollectButton imdb_id={this.props.ids.imdb} />{" "}
          </div>
        </div>
      );
    }
  }

  tvShowInformation() {
    const genres = this.props.genres.map(genre => genre + " ");

    return (
      <div>
        <Row>
          <Col md={12}>
            <FontAwesome name="calendar" className="p-r-xs" />
            {this.props.first_aired}
            <span className="p-l-sm" />
            <FontAwesome name="clock-o" className="p-r-xs" />
            {this.props.runtime}m
            <span className="p-l-sm" />
            <FontAwesome name="list" className="p-r-xs" />
            {this.props.aired_episodes}
          </Col>
        </Row>
        <Row className="m-t-sm">
          <Col md={12}>
            <FontAwesome name="film" className="p-r-xs" />
            {genres}
          </Col>
        </Row>
      </div>
    );
  }

  render() {
    return (
      <Row>
        <Col md={12}>
          {this.tvShowInformation()}
          <div className="m-r-sm m-t">
            <a
              rel="noopener noreferrer"
              target="_blank"
              href={`http://www.imdb.com/title/${this.props.ids.imdb}`}
            >
              <ImdbIcon />
            </a>
          </div>
          {this.sampleButton()}
        </Col>
      </Row>
    );
  }
}

Details.propTypes = {
  ids: PropTypes.any,
  genres: PropTypes.array,
  first_aired: PropTypes.string,
  runtime: PropTypes.number,
  aired_episodes: PropTypes.number
};

export default Details;
