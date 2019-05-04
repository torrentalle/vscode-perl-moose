#!/usr/bin/env node

const path = require('path');
const cp = require('child_process');
const fs = require('fs');

const downloadAndUnzipVSCode = require('vscode-test').downloadAndUnzipVSCode;
const packageInfo = require(path.join(process.cwd(),'package.json'));

var testsFolder = path.join(process.cwd(), 'out', 'test', 'installation');
var testsWorkspace = testsFolder;
var extensionsFolder = path.join(process.cwd(), 'testFixture/empty-extension');
var extensionsDir = path.join(process.cwd(), '.vscode-test/extensions');
var locale = 'en';
var userDataDir = path.join(process.cwd(), '.vscode-test');

 var packageFile = path.join(
    process.cwd(), packageInfo.name + '-' + packageInfo.version + '.vsix'
 );

console.log('### VS Code Package Extension Test Run ###');
console.log('');
console.log('Current working directory: ' + process.cwd());


function runTests(executablePath) {

    var args = [
        testsWorkspace,
        '--extensionDevelopmentPath=' + extensionsFolder,
        '--extensionTestsPath=' + testsFolder,
        '--locale=' + locale,
        '--user-data-dir=' + userDataDir,
        '--extensions-dir=' + extensionsDir
    ];

    console.log('Running extension tests: ' + [executablePath, args.join(' ')].join(' '));

    var cmd = cp.spawn(executablePath, args);

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
    });
}

function installExtensionAndRunTests(executablePath) {
    
    var binPath = executablePath;

    if ( binPath.match(/Code\.exe$/)) {
        binPath = binPath.replace(/Code\.exe$/i,'bin/code.cmd');
    } else if ( ! binPath.match(/bin\/code/)) {
        binPath = executablePath.replace(/code$/,'bin/code');
    }

    var args = [
        '--install-extension='+ packageFile,
        '--extensions-dir=' + extensionsDir,
        '--user-data-dir=' + userDataDir
    ];

    console.log('Installing extension tests: ' + [binPath, args.join(' ')].join(' '));

    var cmd = cp.spawn(binPath, args);

    cmd.stdout.on('data', function (data) {
        console.log(data.toString());
    });

    cmd.stderr.on('data', function (data) {
        console.error(data.toString());
    });

    cmd.on('error', function (data) {
        console.log('Failed to install extension: ' + data.toString());
    });

    cmd.on('close', function (code) {
        console.log('Exited with code: ' + code);

        if (code !== 0) {
            process.exit(code); // propagate exit code to outer runner
        }

        runTests(executablePath);
    });
}


function downloadExecutableInstallAndRunTests() {
    downloadAndUnzipVSCode(process.env.CODE_VERSION).then(executablePath => {
        installExtensionAndRunTests(executablePath)
    }).catch(err => {
        console.error('Failed to run test with error:')
        console.log(err);
        process.exit(1);
    })
}

downloadExecutableInstallAndRunTests()