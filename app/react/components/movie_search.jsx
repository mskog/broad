import React from 'react';
import Results from './movie_search/results';
import NoResults from './movie_search/no_results';

class MovieSearch extends React.Component {
  results() {
    if (this.props.results.length > 0){
      return <Results results={this.props.results} query={this.props.query}/>;
    } else{
      return <NoResults />;
    }
  }

  render() {
    return(
        <div className="row">
          <div className="col-md-12">
            {this.results()}
          </div>
        </div>
    );
  }
}

export default MovieSearch;
