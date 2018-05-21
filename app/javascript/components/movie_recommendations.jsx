import React from "react";
import { connect } from "react-refetch";
import Recommendations from "./movie_recommendations/recommendations";
import Pending from "./pending";
import PropTypes from "prop-types";

class MovieRecommendations extends React.Component {
  render() {
    const { movieRecommendationsFetch } = this.props;
    var results;

    if (movieRecommendationsFetch.fulfilled) {
      results = (
        <Recommendations
          onDownload={this.props.movieRecommendationDownload.bind(this)}
          onHide={this.props.movieRecommendationHide.bind(this)}
          recommendations={movieRecommendationsFetch.value}
        />
      );
    } else {
      results = <Pending />;
    }

    return <div>{results}</div>;
  }
}

MovieRecommendations.propTypes = {
  movieRecommendationsFetch: PropTypes.object.isRequired,
  movieRecommendationDownload: PropTypes.func.isRequired,
  movieRecommendationHide: PropTypes.func.isRequired
};

export default connect(() => ({
  movieRecommendationsFetch: `/api/v1/movie_recommendations`,
  movieRecommendationDownload: id => ({
    movieRecommendationDownloadResponse: {
      url: `/api/v1/movie_recommendations/${id}/download`,
      method: "PUT"
    }
  }),
  movieRecommendationHide: id => ({
    movieRecommendationHideResponse: {
      url: `/api/v1/movie_recommendations/${id}`,
      method: "DELETE"
    }
  })
}))(MovieRecommendations);
