import React from "react";
import Result from "../search/result";
import NoResults from "../search/no_results";

class Results extends React.Component {
  results() {
    const searchType = this.props.search_type;

    if (this.props.results.length == 0) {
      return <NoResults />;
    } else {
      return this.props.results.map(function(result, index) {
        return (
          <Result
            {...result}
            key={result.imdb_id}
            loadDetails={index == 0}
            search_type={searchType}
          />
        );
      });
    }
  }

  render() {
    return (
      <div>
        <ul className="list-unstyled">{this.results()}</ul>
      </div>
    );
  }
}

export default Results;
