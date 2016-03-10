import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Form from './movie_search/form';
import MovieResults from './movie_search/movie_results';

class MovieSearch extends React.Component {
  constructor(props) {
     super(props);
     this.state = {query: props.query};
   }

  updateSearch(query) {
    this.setState({
      query: query
    });
  }

  render() {
    return(
        <Row>
          <Col md={12}>
            <Form disabled="" onChange={this.updateSearch.bind(this)} query={this.state.query} />
            <MovieResults query={this.state.query} />
          </Col>
        </Row>
    );
  }
}
export default MovieSearch;
