import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import SearchForm from "./search_form";
import SearchResults from "./search/search_results";

class TvShowSearch extends React.Component {
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
          <SearchResults
            query={this.state.query}
            fetch={`/api/v1/tv_show_searches?query=${this.state.query}`}
            search_type="tv_show"
          />
        </Col>
      </Row>
    );
  }
}
export default TvShowSearch;
