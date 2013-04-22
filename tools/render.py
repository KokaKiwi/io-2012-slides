#!/usr/bin/env python2
import argparse, codecs, yaml
from markdown import markdown
from jinja2 import Template

parser = argparse.ArgumentParser()
parser.add_argument('-o', '--output', default = None, help = 'Output file.')
parser.add_argument('-t', '--template', default = 'template.html', help = 'Template file.')
parser.add_argument('-c', '--config', default = 'slide_config.template.js', help = 'slide_config.js template.')
parser.add_argument('slides_file', help = 'Slides file.')

def get_metadata(section):
    return yaml.load(section)

def render(infile, outfile):
    md = infile.read()
    md_slides = md.split('\n---\n')

    slides = []
    for md_slide in md_slides[1:]:
        slide = {}

        parts = md_slide.split('\n===\n')
        md_slide = parts[0]
        notes = None
        if len(parts) > 1:
            notes = markdown(parts[1])

        sections = md_slide.split('\n\n')

        metadata_section = sections[0]
        metadata = get_metadata(metadata_section)
        slide.update(metadata)

        content_index = metadata and 1 or 0
        content_section = '\n\n'.join(sections[content_index:])
        slide['content'] = markdown(content_section)
        slide['notes'] = notes

        slides.append(slide)

    metadata = yaml.load(md_slides[0])

    template_file = codecs.open(args.template, 'r', encoding = 'utf8')
    template = Template(template_file.read())
    template_file.close()

    outfile.write(template.render(locals()))

    slide_config_template_file = codecs.open(args.config, 'r', encoding = 'utf8')
    slide_config_template = Template(slide_config_template_file.read())
    slide_config_template_file.close()

    slide_config_file = codecs.open('slide_config.js', 'w+', encoding = 'utf8')
    slide_config_file.write(slide_config_template.render(locals()))
    slide_config_file.close()

def main(args):
    infile = codecs.open(args.slides_file, 'r', encoding = 'utf8')
    outputfilename = args.output
    if outputfilename == None:
        outputfilename = args.slides_file.replace('.md', '.html')
    outfile = codecs.open(outputfilename, 'w+', encoding = 'utf8')

    render(infile, outfile)

    infile.close()
    outfile.close()

if __name__ == '__main__':
    args = parser.parse_args()
    main(args)
