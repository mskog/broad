import React from "react";
import PosterImage from "../poster_image";
import Title from "../search/title";
import MovieReleaseDetails from "./movies/release_details";
import TvShowReleaseDetails from "./tv_shows//release_details";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import Panel from "react-bootstrap/lib/Panel";
import PropTypes from "prop-types";

class Result extends React.Component {
  poster() {
    var posterSrc = `/posters/${this.props.tmdb_id}?type=${
      this.props.search_type
    }`;
    return (
      <Col sm={3}>
        <PosterImage src={posterSrc} />
      </Col>
    );
  }

  releaseDetails() {
    if (this.props.search_type == "movie") {
      return (
        <MovieReleaseDetails
          imdb_id={this.props.imdb_id}
          loadDetails={this.props.loadDetails}
        />
      );
    } else {
      return (
        <TvShowReleaseDetails
          imdb_id={this.props.imdb_id}
          loadDetails={this.props.loadDetails}
        />
      );
    }
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
              {this.releaseDetails()}
            </Col>
          </Row>
        </Panel>
      </li>
    );
  }
}

Result.propTypes = {
  search_type: PropTypes.string,
  tmdb_id: PropTypes.string,
  downloaded: PropTypes.bool,
  loadDetails: PropTypes.bool,
  title: PropTypes.string,
  year: PropTypes.number,
  overview: PropTypes.string,
  imdb_id: PropTypes.string
};

export default Result;
