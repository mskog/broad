import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import Panel from "react-bootstrap/lib/Panel";
import PropTypes from "prop-types";
import Title from "./title";
import PosterImage from "../poster_image";
import ReleaseDetails from "./release_details";

class Result extends React.Component {
  poster() {
    var posterSrc = `/posters/${this.props.tmdb_id}?type=tv_show`;
    return (
      <Col sm={3}>
        <PosterImage src={posterSrc} />
      </Col>
    );
  }

  render() {
    return (
      <li>
        <Panel>
          <Row>
            {this.poster()}
            <Col sm={9}>
              <Row>
                <Col sm={12}>
                  <Title title={this.props.title} year={this.props.year} />
                </Col>
              </Row>
              <Row>
                <Col sm={12}>
                  <p>{this.props.overview}</p>
                </Col>
              </Row>
              <ReleaseDetails
                imdb_id={this.props.imdb_id}
                loadDetails={this.props.loadDetails}
              />
            </Col>
          </Row>
        </Panel>
      </li>
    );
  }
}

Result.propTypes = {
  tmdb_id: PropTypes.string,
  downloaded: PropTypes.bool,
  loadDetails: PropTypes.bool,
  title: PropTypes.string,
  year: PropTypes.number,
  overview: PropTypes.string,
  imdb_id: PropTypes.string
};

export default Result;
