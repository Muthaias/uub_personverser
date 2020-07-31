import sys

class ArgumentParser:
    def __init__(self, name: str, arg: str, count: int, default, parser):
        self.name = name
        self.arg = arg
        self.count = count
        self.parser = parser
        self.default = default
    
    def parse(self, argv):
        try:
            position = argv.index(self.arg) + 1
            params = argv[position:position + self.count]
            return self.parser(params)
        except:
            return self.default

    @staticmethod
    def parse_argv(parsers: [], argv: [str]):
        length = len(argv)
        return {parser.name:parser.parse(argv) for parser in parsers}