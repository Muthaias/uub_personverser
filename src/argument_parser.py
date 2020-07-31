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
            return self.parse_no_default(argv)
        except:
            return self.default

    def parse_no_default(self, argv):
        position = argv.index(self.arg) + 1
        params = argv[position:position + self.count]
        return self.parser(params)

    @staticmethod
    def parse_argv(parsers: [], argv: [str]):
        length = len(argv)
        return {parser.name:parser.parse(argv) for parser in parsers}

class StaticArgument:
    def __init__(self, name: str, value):
        self.name = name
        self.value = value
    
    def parse(self, argv):
        return self.value

    def parse_no_default(self, argv):
        return self.parse(argv)

class ArgumentGroup:
    def __init__(self, name: str, parsers: [ArgumentParser]):
        self.name = name
        self.parsers = parsers
    
    def parse(self, argv):
        return {parser.name:parser.parse(argv) for parser in self.parsers}

    def parse_no_default(self, argv):
        return self.parse(argv)

class MutexArgumentParser:
    def __init__(self, name: str, parsers: [ArgumentParser]):
        self.name = name
        self.parsers = parsers
    
    def parse(self, argv):
        for parser in self.parsers:
            try:
                result = parser.parse_no_default(argv)
                return result
            except:
                pass