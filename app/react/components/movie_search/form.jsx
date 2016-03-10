import React from 'react';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Input from 'react-bootstrap/lib/Input';
import Button from 'react-bootstrap/lib/Button';
import FontAwesome from 'react-fontawesome';

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
      this.submit();
    }
  }

  submit(){
    this.props.onChange(this.refs.input.getValue());
    this.setState({
      query: ""
    });
  }

  render() {
    var submitButton = <Button bsStyle='success' onClick={this.submit.bind(this)}><FontAwesome name='search' /></Button>;

    return(
        <Row>
          <Col md={12}>
            <Input ref='input' type='text' value={this.state.query} onKeyPress={this.handleKeyPress.bind(this)} onChange={this.handleChange.bind(this)} buttonAfter={submitButton}/>
          </Col>
        </Row>
    );
  }
}

export default Form;
