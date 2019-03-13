import * as assert from 'assert';
import { commands, Uri } from 'vscode';
import { join, basename, normalize, dirname } from 'path';
import * as fs from 'fs';


function assertUnchangedTokens(testFixurePath, done) {
    let fileName = basename(testFixurePath);

    return commands.executeCommand('_workbench.captureSyntaxTokens', Uri.file(testFixurePath)).then(data => {
        try {
            let resultsFolderPath = join(dirname(dirname(testFixurePath)), 'colorize-results');
            if (!fs.existsSync(resultsFolderPath)) {
                fs.mkdirSync(resultsFolderPath);
            }
            let resultPath = join(resultsFolderPath, fileName.replace('.', '_') + '.json');
            console.log(resultPath);
            if (fs.existsSync(resultPath)) {
                let previousData = JSON.parse(fs.readFileSync(resultPath).toString());
                try {
                    assert.deepEqual(data, previousData);
                } catch (e) {
                    if (Array.isArray(data) && Array.isArray(previousData) && data.length === previousData.length) {
                        for (let i = 0; i < data.length; i++) {
                            let d = data[i];
                            let p = previousData[i];
                            if (d.c !== p.c || hasThemeChange(d.r, p.r)) {
                                throw e;
                            }
                        }
                        // different but no tokenization ot color change: no failure
                        fs.writeFileSync(resultPath, JSON.stringify(data, null, '\t'), { flag: 'w' });
                    } else {
                        throw e;
                    }
                }
            } else {
                fs.writeFileSync(resultPath, JSON.stringify(data, null, '\t'));
            }
            done();
        } catch (e) {
            done(e);
        }
    }, done);
}

function hasThemeChange(d, p) {
    let keys = Object.keys(d);
    for (let key of keys) {
        if (d[key] !== p[key]) {
            return true;
        }
    }
    return false;
};

suite('Colorization', () => {
    let extensionColorizeFixturePath = normalize(join(__dirname, '../../', 'testFixture/', 'colorize-fixtures'));
    if (fs.existsSync(extensionColorizeFixturePath)) {
        let fixturesFiles = fs.readdirSync(extensionColorizeFixturePath);
        fixturesFiles.forEach(fixturesFile => {
            // define a test for each fixture
            test(fixturesFile, function (done) {
                assertUnchangedTokens(join(extensionColorizeFixturePath, fixturesFile), done);
            });
        });
    }
});
