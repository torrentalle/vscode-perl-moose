// @ts-check
'use strict';

import * as vscode from 'vscode'
import * as assert from 'assert'
import * as fs from 'fs'
import { getFixturePath, getFixtureUri, activate } from './helper'
export let doc: vscode.TextDocument
export let editor: vscode.TextEditor

suite('Perl Moose Extension', () => {
  
  const ext = vscode.extensions.getExtension('torrentalle.perl-moose')

  test('Extension is installed', () =>  { 
    assert.notEqual(ext, undefined, 'Cannot getExtension')
  });


  test('Extension manifest matches current JSON ', () =>  {  

    const resultPath = getFixturePath('../package.json')
    let localData = JSON.parse(fs.readFileSync(resultPath).toString());

    let packageData = JSON.parse(JSON.stringify(ext.packageJSON));
    
    delete packageData.extensionLocation
    delete packageData.id
    delete packageData.identifier
    delete packageData.isBuiltin
    delete packageData.isUnderDevelopment

    assert.deepEqual(packageData, localData, 'Extension is installed');
 
  });


  test('Extension can be activated', async () =>  {  

    const docUri = getFixtureUri('InstallTest.pm')
    await activate(docUri)
    
    assert.equal(ext.isActive, true, "Check if extension is active")

  });

});

