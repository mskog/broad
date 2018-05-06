import React from "react";
import { connect, PromiseState } from "react-refetch";
import Results from "./results";
import NoResults from "./no_results";
import Pending from "../pending";

class MovieResults extends React.Component {
  render() {
    const { movieSearchFetch } = this.props;
    var results;

    if (movieSearchFetch.fulfilled) {
      results = (
        <Results results={movieSearchFetch.value} query={this.props.query} />
      );
    } else {
      results = <Pending query={this.props.query} />;
    }

    return (
      <div>
        <h3>Results for "{this.props.query}"</h3>
        {results}
      </div>
    );
  }
}

export default connect(props => ({
  movieSearchFetch: `/api/v1/movie_searches?query=${props.query}`
}))(MovieResults);
