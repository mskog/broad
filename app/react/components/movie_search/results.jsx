import React from 'react';
import Result from './result';

class Results extends React.Component {
  render() {
    var resultNodes = this.props.results.map(function(result) {
      return (
        <Result {...result} key={result.imdb_id} />
    )});

    return(
        <div>
          <h3>Results for "{this.props.query}"</h3>
          <ul className='list-unstyled'>
            {resultNodes}
          </ul>
        </div>
    );
  }
}

export default Results;
