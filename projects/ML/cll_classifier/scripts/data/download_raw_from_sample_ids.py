import time, sys
from pathlib import Path
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed

GSM_LIST  = sys.argv[1]
OUT_DIR   = Path(sys.argv[2])
N_WORKERS = 8



def gsm_to_url(gsm_id):

    prefix = gsm_id[:6] + "nnn"
    
    return f"https://ftp.ncbi.nlm.nih.gov/geo/samples/{prefix}/{gsm_id}/suppl/{gsm_id}.CEL.gz"


def download_gsm(gsm_id, max_retries=3, delay=5):
    
    url = gsm_to_url(gsm_id)
    filepath = OUT_DIR / f"{gsm_id}.CEL.gz"
    
    if filepath.exists():
        print(f"{gsm_id} already exists, skipping.")
        return

    for attempt in range(1, max_retries + 1):
        try:
            print(f"Downloading {gsm_id} (attempt {attempt})...")
            urllib.request.urlretrieve(url, filepath)
            print(f"{gsm_id} downloaded successfully.")
            return
        except Exception as e:
            print(f"Error downloading {gsm_id} (attempt {attempt}): {e}")
            time.sleep(delay)
    
    print(f"Failed to download {gsm_id} after {max_retries} attempts.")



if __name__ == "__main__":

    OUT_DIR.mkdir(exist_ok=True)

    gsm_list = [gsm[:-1] for gsm in open(GSM_LIST).readlines()]

    with ThreadPoolExecutor(max_workers=N_WORKERS) as executor:
        futures = [executor.submit(download_gsm, gsm) for gsm in gsm_list]
        for future in as_completed(futures):
            pass  # all printing handled inside download_gsm
