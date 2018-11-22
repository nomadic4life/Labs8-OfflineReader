import React from 'react';
import { GoogleLogin } from 'react-google-login';

const GOOGLE_CLIENT_ID = process.env.GOOGLE_CLIENT_ID;
export const google_client_id = GOOGLE_CLIENT_ID;

const GoogleLoginButton = props => {
	const responseGoogleSuccess = response => {
		console.log(response);
		console.log('google login succeeded');
		if (response.profileObj) {
			localStorage.setItem('goog_avatar_url', response.profileObj.imageUrl);
			localStorage.setItem('goog_name', response.profileObj.name);
			localStorage.setItem('goog_email', response.profileObj.email);
		}
		props.convertGoogleToken(response.Zi.access_token);
	};

	const responseGoogleFailure = response => {
		console.log(response);
		console.log('Google Login failed');
	};

	return (
		<GoogleLogin
			clientId={google_client_id}
			buttonText="Login with Google"
			onSuccess={responseGoogleSuccess}
			onFailure={responseGoogleFailure}
			className="loginBtn loginBtn--google"
			prompt="select_account"
			redirectUri="http://localhost:3000/secret/"
		/>
	);
};

export default GoogleLoginButton;