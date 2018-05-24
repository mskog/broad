import React from "react";
import { connect } from "react-refetch";
import Results from "./results";
import Pending from "../pending";

import PropTypes from "prop-types";

class SearchResults extends React.Component {
  render() {
    const { fetchFunction } = this.props;
    var results;

    if (fetchFunction.fulfilled) {
      results = (
        <Results
          results={fetchFunction.value}
          query={this.props.query}
          search_type={this.props.search_type}
        />
      );
    } else {
      results = <Pending query={this.props.query} />;
    }

    return (
      <div>
        <h3>Results for &quot;{this.props.query}&quot;</h3>
        {results}
      </div>
    );
  }
}

SearchResults.propTypes = {
  query: PropTypes.string,
  search_type: PropTypes.string,
  fetchFunction: PropTypes.any
};

export default connect(props => ({
  fetchFunction: props.fetch
}))(SearchResults);
