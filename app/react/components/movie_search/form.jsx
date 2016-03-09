import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Input from 'react-bootstrap/lib/Input';

class Form extends React.Component {
  constructor(props) {
     super(props);
     this.state = {query: props.query};
   }

  handleChange() {
    this.setState({
      query: this.refs.input.getValue()
    });
  }

  handleKeyPress(target) {
    if(target.charCode==13){
      this.props.onChange(this.refs.input.getValue());
    }
  }

  render() {
    return(
        <Row>
          <Col md={12}>
            <Input disabled={this.props.disabled} ref='input' type='text' value={this.state.query} onKeyPress={this.handleKeyPress.bind(this)} onChange={this.handleChange.bind(this)} />
          </Col>
        </Row>
    );
  }
}

export default Form;
