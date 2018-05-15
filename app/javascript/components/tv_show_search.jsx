import React from "react";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import SearchForm from "./search_form";
import TvShowResults from "./tv_show_search/tv_show_results";

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
          <TvShowResults query={this.state.query} />
        </Col>
      </Row>
    );
  }
}
export default TvShowSearch;
