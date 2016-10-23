import React from 'react';
import { connect, PromiseState } from 'react-refetch';
import Recommendations from './movie_recommendations/recommendations';
import Pending from './pending';

class MovieRecommendations extends React.Component {
  render() {
    const { movieRecommendationsFetch } = this.props
    var results;

    if (movieRecommendationsFetch.fulfilled){
      results = <Recommendations onDownload={this.props.movieRecommendationDownload.bind(this)} recommendations={movieRecommendationsFetch.value}/>;
    } else{
      results = <Pending />;
    }

    return(
      <div>
        {results}
      </div>
    );
  }
}

export default connect(props => ({
  movieRecommendationsFetch: `/api/v1/movie_recommendations`,
  movieRecommendationDownload: id => ({
    movieRecommendationDownloadResponse: {
      url: `/api/v1/movie_recommendations/${id}/download`,
      method: 'PUT'
    }
  })
}))(MovieRecommendations)
