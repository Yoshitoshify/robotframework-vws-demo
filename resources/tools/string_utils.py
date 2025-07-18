def write_binary_file(path, content):
    with open(path, 'wb') as f:
        f.write(content)
def extract_file_name_from_url(url):
    return url.rstrip('/').split('/')[-1]
