#!/usr/bin/env node

var yaml = require('js-yaml');
var fs   = require('fs');
var path = require('path');

function processDir(srcDir, outDir) {

    if (!fs.existsSync(outDir)){
        fs.mkdirSync(outDir);
    }
    
    fs.readdirSync(srcDir).forEach(yamlFile => {
        let ext = path.extname(yamlFile)
        let fullPath = path.join(srcDir, yamlFile)
        if (fs.statSync(fullPath).isDirectory()) {
            processDir(
                path.join(srcDir, yamlFile),
                path.join(outDir, yamlFile)
            );
        } else if (ext.match(/^\.ya?ml$/)) {
            let jsonFile = path.basename(yamlFile, ext) + '.json';
            let jsonPath = path.join(outDir, jsonFile);
            let yamlPath = path.join(srcDir, yamlFile);
            try {
                let src = yaml.safeLoad(fs.readFileSync(yamlPath, 'utf8'));
                fs.writeFileSync(jsonPath, JSON.stringify(src, null, '  '));
                console.log(jsonPath);
             } catch (e) {
                console.error(e);
                process.exit(1);
            }
        }
    });
}


var src = process.env.SYNTAX_SRC_DIR || path.join(process.cwd(), 'src', 'syntaxes')
var out = process.env.SYNTAX_OUT_DIR || path.join(process.cwd(), 'syntaxes')
processDir(src, out);