#!/bin/bash

# Check if a sandbox name was provided
if [ -z "$1" ]
then
  echo "Please provide a sandbox name as an argument."
  exit 1
fi

# Move to src
cd src

# Make sandbox react apps directory
mkdir sandbox_react_apps

# Set the sandbox directory path
SANDBOX_DIR="sandboxes/${1}"
SANDBOX_REACT_APP_DIR="sandbox_react_apps/${1}_react_app"

# Check if the sandbox directory exists
if [ ! -d "$SANDBOX_DIR" ]
then
  echo "Sandbox directory not found: $SANDBOX_DIR"
  exit 1
fi

# Create a new React app directory and copy the contents of the sandbox
mkdir "$SANDBOX_REACT_APP_DIR"
mkdir "$SANDBOX_REACT_APP_DIR"/src
cp -R "$SANDBOX_DIR"/* "$SANDBOX_REACT_APP_DIR"/src

# Change to the new React app directory
cd "$SANDBOX_REACT_APP_DIR"

# Move dependencies.json to package.json
mv src/dependencies.json package.json
mv src/README.md .

# Add additional fields to package.json
node -e 'const fs = require("fs"); const pkg = JSON.parse(fs.readFileSync("package.json", "utf-8")); pkg.name = "sandboxes"; pkg.version = "0.1.0"; pkg.private = true; pkg.eslintConfig = { "extends": ["react-app", "react-app/jest"] }; pkg.browserslist = [">0.2%", "not dead", "not ie <= 11", "not op_mini all"]; pkg.scripts = { "start": "react-scripts start", "build": "react-scripts build", "test": "react-scripts test", "eject": "react-scripts eject" }; fs.writeFileSync("package.json", JSON.stringify(pkg, null, 2));'

# Create public folder with index.html
mkdir public
cat > public/index.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="description" content="Phantom Wallet CodeSandbox">
	<meta name="keywords" content="Phantom, Phantom Wallet, Phantom-Wallet, CodeSandbox, Solana, Ethereum, Crypto, Blockchain, Love">
	<meta name="author" content="Phantom">
	<meta name="theme-color" content="#000000">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="manifest" href="%PUBLIC_URL%/manifest.json">
	<link rel="shortcut icon" href="%PUBLIC_URL%/favicon.ico">
	<title>Phantom Wallet – CodeSandbox</title>
</head>
<style>
	* {
		box-sizing: border-box;
		margin: 0;
		color: #fff;
	}

	html,body {
		font-family: sans-serif;
	}
</style>
<body>
	<noscript>
		You need to enable JavaScript to run this app.
	</noscript>
	<div id="root"></div>
</body>
</html>
EOL

# Create tsconfig.json
cat > tsconfig.json << EOL
{
  "include": [
    "./src/**/*"
  ],
  "exclude": [
    "node_modules"
  ],
  "compilerOptions": {
    "strict": false,
    "esModuleInterop": true,
    "lib": ["DOM", "ES6", "DOM.Iterable", "ScriptHost", "ES2016.Array.Include"],
    "jsx": "react",
    "target": "es6",
    "allowJs": true,
    "skipLibCheck": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": false,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "noImplicitAny": false
  }
}
EOL

# Create .prettierrc
cat > .prettierrc << EOL
{
  "printWidth": 120,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5"
}
EOL

# Update index.tsx to render app
cat > src/index.tsx << EOL
import React from 'react';
import ReactDOM from 'react-dom';

import App from './App';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
EOL

# Create a .gitignore file
cat > .gitignore << EOL
# Dependencies
node_modules

# MacOS
.DS_Store

# VSCode
.vscode/
workspace*
EOL

# Remove menu from sandbox
SIDEBAR_FILE="src/components/Sidebar/index.tsx"
sed '/<Menu>/,/<\/Menu>/d' "$SIDEBAR_FILE" > tmp_sidebar.tsx && mv tmp_sidebar.tsx "$SIDEBAR_FILE"

# Install dependencies
yarn install

# Done
echo "Successfully created a standalone React app for $1"
