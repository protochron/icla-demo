var MainForm = React.createClass({
  handleSubmit: function(event) {
    e.preventDefault();
    var userEmail = this.state.email.trim();
    if (!userEmail) return;
    return;
  },

  handleFormSubmit: function(event) {
    this.setState({email: event.target.value});
    this.props.onSubmit({email: event.target.value});
  },

  render:function () {
    return (
        <div>
          <div className="panel-body">
            <p>Thank you for your interest in contributing to the Apache Software Foundation. To continue with the ICLA process, you first need to provide a valid email address.</p>
            <p>Please enter a valid email address to continue the process. </p>
          </div>
          <div className="row">
            <div className="col-md-10 col-md-offset-2">
              <form className="form-horizontal col-md-8" onSubmit={this.handleSubmit} >
                <div className="form-group">
                  <label className="col-sm-2 control-label">Email</label>
                  <div className="col-sm-10">
                    <input className="form-control" type="text" name="email" onChange={this.handleEmailChange} />
                  </div>
                </div>
                <div className="text-center">
                  <input className="btn" type="submit" value="Submit"/>
                </div>
              </form>
            </div>
          </div>
        </div>
    );
  }
});
var EmailForm = React.createClass({
  getInitialState: function () {
    return {
      email: '',
      submitted: false,
    };
  },

  handleSubmit: function (emailComponent) {
    this.setState({email: emailComponent.email, submitted: true});
  },

  render: function() {
    if (!this.state.submitted) {
      return (
        <MainForm onSubmit={this.handleSubmit} />
      );
    } else {
      return (
        <div>
          <div className="alert alert-success">
            <p>Thank you for submitting your ICLA request. An email should arrive in you inbox shortly with a link to confirm that you agree to the terms and conditions.</p>
            <a href="#">Debug: Click here to skip the whole validation part</a>
          </div>
          <MainForm />
        </div>
      );
    }
  }
});

React.render(
  <EmailForm />,
  document.getElementById('form-mount')
);
