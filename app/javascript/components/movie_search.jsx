import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import SearchForm from "./search_form";
import MovieResults from "./search/movies/movie_results";
import PropTypes from "prop-types";

class MovieSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = { query: props.query };
  }

  updateSearch(query) {
    this.setState({
      query: query
    });
  }

  render() {
    return (
      <Row>
        <Col md={12}>
          <SearchForm
            disabled=""
            onChange={this.updateSearch.bind(this)}
            query={this.state.query}
          />
          <MovieResults query={this.state.query} search_type="movie" />
        </Col>
      </Row>
    );
  }
}

MovieSearch.propTypes = {
  query: PropTypes.string.isRequired
};

export default MovieSearch;
