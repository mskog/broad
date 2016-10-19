import React from 'react';
import { connect, PromiseState } from 'react-refetch';
import shuffle from 'shuffle-array';
import Recommendations from './movie_recommendations/recommendations';
import Pending from './pending';

class MovieRecommendations extends React.Component {
  render() {
    const { movieRecommendationsFetch } = this.props
    var results;

    if (movieRecommendationsFetch.fulfilled){
      let movies = shuffle(movieRecommendationsFetch.value).slice(0,4);
      results = <Recommendations recommendations={movies}/>;
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
}))(MovieRecommendations)
