#!/usr/bin/env node

var cp = require('child_process');
var path = require('path');
var fs = require('fs');

var version = process.env.CODE_VERSION || '*';
var isInsiders = version === 'insiders';

const currentPath = process.cwd();

var testRunFolder = path.join('.vscode-test', isInsiders ? 'insiders' : 'stable');
var testRunFolderAbsolute = path.join(currentPath, testRunFolder);

var userDataDir = path.join(currentPath, '.vscode-test');
var extensionsDir = path.join(currentPath, '.vscode-test/extensions');
var codeExtensionPath = path.join(currentPath, 'testFixture/empty-extension');

var windowsExecutable = path.join(testRunFolderAbsolute, 'bin','code');
var darwinExecutable = path.join(testRunFolderAbsolute, 'Visual Studio Code.app', 'Contents', 'Resources', 'app', 'bin', 'code');
var  linuxExecutable = path.join(testRunFolderAbsolute, 'VSCode-linux-x64', 'bin', 'code');
if (['0.10.1', '0.10.2', '0.10.3', '0.10.4', '0.10.5', '0.10.6', '0.10.7', '0.10.8', '0.10.9'].indexOf(version) >= 0) {
    linuxExecutable = path.join(testRunFolderAbsolute, 'VSCode-linux-x64', 'Code', 'bin', 'code');
}
var executable = (process.platform === 'darwin') ? darwinExecutable : process.platform === 'win32' ? windowsExecutable : linuxExecutable;

let localData = JSON.parse(
   fs.readFileSync(path.join(currentPath,'package.json')).toString()
);
var packageFile = path.join(
   currentPath, localData.name + '-' + localData.version + '.vsix'
);



function testEnvVars(codeTestPath) {
   var env = Object.create( process.env );
   env.CODE_TESTS_DATA_DIR = userDataDir;
   env.CODE_EXTENSIONS_PATH = codeExtensionPath;
   if (codeTestPath) {
      env.CODE_TESTS_PATH = path.join(currentPath, codeTestPath)
   }

   return env;
}


function downloadExecutableAndRunTests() {
   var env = testEnvVars('out/test/vscode');
   
   execute('node', ['./node_modules/vscode/bin/test'], env, runTests);
}

function installExtension(callback) {  
   var run = "bash";
   var args = [
      executable,
      '--install-extension='+ packageFile,
      '--extensions-dir=' + extensionsDir,
      '--user-data-dir=' + userDataDir
   ];
   execute(run, args, false, callback);
   
}

function runTests() {
   installExtension( function() {
      var envTests = testEnvVars();
      envTests.CODE_TESTS_WORKSPACE = '--extensions-dir=' + extensionsDir;
      execute('node', ['./node_modules/vscode/bin/test'], envTests );
   });
}

function execute(command, args, env, callback) {
   var options = { }
   if (env) {
      options = {
         env: env
      }
   }
   console.log('Running: ' + [command, args.join(' ')].join(' '));
   
   var cmd = cp.spawn(command, args, options );

   cmd.stdout.on('data', function (data) {
      console.log(data.toString());
   });

   cmd.stderr.on('data', function (data) {
      console.error(data.toString());
   });

   cmd.on('error', function (data) {
      console.log('Failed to execute tests: ' + data.toString());
   });

   cmd.on('close', function (code) {
      console.log('Tests exited with code: ' + code);
      if (code !== 0) {
         process.exit(code); // propagate exit code to outer runner
      }
      if (callback) {
         callback()
      }
   });

}

function test() {
   fs.exists(executable, function (exists) {
      if (exists) {
          runTests();
      } else {
          downloadExecutableAndRunTests();
      }
   });
   
}

fs.exists(packageFile, function (exists) {
   if (exists) {
       test();
   } else {
      exitWithError(packageFile + ' not found');
   }
});

function exitWithError(error) {
   console.error('Error running tests: ' + error.toString());
   process.exit(1);
}
