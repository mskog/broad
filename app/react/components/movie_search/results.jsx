import React from 'react';
import Result from './result';
import NoResults from './no_results';

class Results extends React.Component {
  results(){
    if (this.props.results.length == 0){
      return <NoResults />
    }else{
      return this.props.results.map(function(result) {
        return (
          <Result {...result} key={result.imdb_id} />
      )});
    }

  }

  render() {
    return(
        <div>
          <ul className='list-unstyled'>
            {this.results()}
          </ul>
        </div>
    );
  }
}

export default Results;
