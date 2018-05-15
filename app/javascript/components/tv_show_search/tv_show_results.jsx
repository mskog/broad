import React from "react";
import { connect, PromiseState } from "react-refetch";
import Results from "./results";
import NoResults from "./no_results";
import Pending from "../pending";

class TvShowResults extends React.Component {
  render() {
    const { tvShowFetch } = this.props;
    var results;

    if (tvShowFetch.fulfilled) {
      results = (
        <Results results={tvShowFetch.value} query={this.props.query} />
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
  tvShowFetch: `/api/v1/tv_show_searches?query=${props.query}`
}))(TvShowResults);
