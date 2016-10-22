import React from 'react';
import shuffle from 'shuffle-array';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Recommendation from './recommendation';

class Recommendations extends React.Component {
  constructor(props) {
    super(props);
    this.state = {recommendations: shuffle(props.recommendations)};
    this.handleDownload = this.handleDownload.bind(this);
   }

  removeItem(id) {
    let recommendations = this.state.recommendations;
    let index = this.state.recommendations.findIndex(thing => {
      return thing.id == id;
    });
    recommendations.splice(index, 1);
    this.setState(recommendations: recommendations);
  }

  handleDownload(id) {
    this.removeItem(id);
  }

  recommendations(){
    let movies = this.state.recommendations.slice(0,4);
    let handleDownload = this.handleDownload;
    if (movies.length == 0){
      return "Nothing";
    }else{
      return movies.map(function(result) {
        return (
          <Recommendation {...result} onDownload={handleDownload} />
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
