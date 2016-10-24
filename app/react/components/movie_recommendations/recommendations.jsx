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
    this.handleHide = this.handleHide.bind(this);
   }

  removeItem(index) {
    let recommendations = this.state.recommendations;
    recommendations.splice(index, 1);
    this.setState({recommendations: recommendations});
  }

  handleDownload(id) {
    let index = this.state.recommendations.findIndex(thing => {
      return thing.id == id;
    });
    let movieRecommendation = this.state.recommendations[index];
    this.removeItem(index);
    this.props.onDownload(movieRecommendation.id);
  }

  handleHide(id) {
    let index = this.state.recommendations.findIndex(thing => {
      return thing.id == id;
    });
    let movieRecommendation = this.state.recommendations[index];
    this.removeItem(index);
    this.props.onHide(movieRecommendation.id);
  }

  recommendations(){
    let movies = this.state.recommendations.slice(0,4);
    let handleDownload = this.handleDownload;
    let handleHide = this.handleHide;
    if (movies.length == 0){
      return "Nothing";
    }else{
      return movies.map(function(result) {
        return (
          <Recommendation {...result} onDownload={handleDownload} onHide={handleHide} />
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
