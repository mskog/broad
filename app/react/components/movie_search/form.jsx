import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import FormControl from 'react-bootstrap/lib/FormControl';
import Button from 'react-bootstrap/lib/Button';
import FontAwesome from 'react-fontawesome';

class Form extends React.Component {
  constructor(props) {
     super(props);
     this.state = {query: props.query};
   }

  handleChange(event) {
    this.setState({
      query: event.target.value
    });
  }

  handleKeyPress(target) {
    if(target.charCode==13){
      this.submit();
    }
  }

  submit(){
    var value = this.state.query;
    if (value.length == 0){
      return;
    }
    this.props.onChange(value);
    this.setState({
      query: ""
    });
  }

  render() {
    var submitButton = <Button bsStyle='success' onClick={this.submit.bind(this)}><FontAwesome name='search' /></Button>;

    return(
        <Row>
          <Col md={12}>
            <FormControl type='text' value={this.state.query} onKeyPress={this.handleKeyPress.bind(this)} onChange={this.handleChange.bind(this)} buttonAfter={submitButton}/>
          </Col>
        </Row>
    );
  }
}

export default Form;
