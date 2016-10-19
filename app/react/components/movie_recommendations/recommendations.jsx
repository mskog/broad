import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Recommendation from './recommendation';

class Recommendations extends React.Component {
  recommendations(){
    if (this.props.recommendations.length == 0){
      return "Nothing";
    }else{
      return this.props.recommendations.map(function(result) {
        return (
          <Recommendation {...result} />
      )});
    }

  }

  render() {
    return(
        <div>
          <ul className='list-unstyled'>
            <Row>
              {this.recommendations()}
            </Row>
          </ul>
        </div>
    );
  }
}

export default Recommendations;
