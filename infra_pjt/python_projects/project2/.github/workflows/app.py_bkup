import csv
import webbrowser

def open_urls_from_csv(csv_file):
    with open(csv_file, newline='') as csvfile:
        url_reader = csv.reader(csvfile)
        for row in url_reader:
            if row:  # check if row is not empty
                url = row[0].strip()  # assuming URL is in the first column
                webbrowser.open(url)

if __name__ == "__main__":
    csv_file_path = "/workspaces/development_public/infra_pjt/python_projects/project2/urls.csv"
    open_urls_from_csv(csv_file_path)
