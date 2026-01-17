from __future__ import annotations

import json
from pathlib import Path


# Input
SRC_DIR = Path("./script/data")

# Output 1: tag json
OUT_TAG_DIR = Path("./data/dfh/tags/damage_type")

# Output 2: mcfunction
OUT_MCF_DIR = Path("./data/dfh/function/logic/types")

# Output 3: advancement json
OUT_ADV_DIR = Path("./data/dfh/advancement/hurt")

# Output 4: all.json
OUT_ALL_FILE = Path("./data/dfh/tags/damage_type/sys/all.json")


def safe_name(raw: str) -> str:
    """Replace ':' and '/' with '___' for filesystem-safe names (per your rule)."""
    return raw.replace(":", "___").replace("/", "___")

def add_default_namespace(name: str) -> str:
    if ":" in name:
        return name
    else:
        return f"minecraft:{name}"


def main() -> None:
    if not SRC_DIR.exists():
        raise FileNotFoundError(f"Source directory not found: {SRC_DIR.resolve()}")

    OUT_TAG_DIR.mkdir(parents=True, exist_ok=True)
    OUT_MCF_DIR.mkdir(parents=True, exist_ok=True)
    OUT_ADV_DIR.mkdir(parents=True, exist_ok=True)
    OUT_ALL_FILE.parent.mkdir(parents=True, exist_ok=True)

    src_files = sorted(SRC_DIR.glob("*.json"))
    if not src_files:
        print(f"No JSON files found in: {SRC_DIR.resolve()}")
        return

    total_strings = 0
    written_tag = 0
    written_mcf = 0
    written_adv = 0

    # collect all strings here
    all_strings: list[str] = []

    for src in src_files:
        try:
            data = json.loads(src.read_text(encoding="utf-8"))
        except Exception as e:
            print(f"[SKIP] Failed to read/parse JSON: {src} ({e})")
            continue

        if not isinstance(data, list) or not all(isinstance(x, str) for x in data):
            print(f"[SKIP] JSON root is not a list of strings: {src}")
            continue

        for s in data:
            total_strings += 1
            all_strings.append(s)

            fixed = safe_name(s)  # <文件名> without extension
            with_default_ns = add_default_namespace(s)

            # ---------- File A: ./data/tags/damage_type/<fixed>.json ----------
            tag_path = OUT_TAG_DIR / f"{fixed}.json"
            tag_obj = {"values": [s]}  # keep original string in values
            tag_path.write_text(
                json.dumps(tag_obj, ensure_ascii=False, indent=4) + "\n",
                encoding="utf-8",
            )
            written_tag += 1

            # ---------- File B: ./data/dfh/function/logic/types/<fixed>.mcfunction ----------
            mcf_path = OUT_MCF_DIR / f"{fixed}.mcfunction"
            mcf_content = f'function dfh:dmg_recieve {{type:"{with_default_ns}"}}\n'
            mcf_path.write_text(mcf_content, encoding="utf-8")
            written_mcf += 1

            # ---------- File C: ./data/dfh/advancement/hurt/<fixed>.json ----------
            adv_path = OUT_ADV_DIR / f"{fixed}.json"
            adv_obj = {
                "criteria": {
                    "hurt": {
                        "trigger": "entity_hurt_player",
                        "conditions": {
                            "damage": {
                                "type": {
                                    "tags": [
                                        {
                                            "expected": True,
                                            "id": f"dfh:{fixed}",
                                        }
                                    ]
                                }
                            },
                            "player": [
                                {
                                    "condition": "inverted",
                                    "term": {
                                        "condition": "value_check",
                                        "range": {
                                            "min": 1
                                        },
                                        "value": {
                                            "type": "score",
                                            "target": {
                                                "type": "fixed",
                                                "name": f"{with_default_ns}"
                                            },
                                            "score": "dfh.disabled_trigger"
                                        }
                                    }
                                }
                            ]
                        },
                    }
                },
                "rewards": {
                    "function": f"dfh:logic/types/{fixed}",
                },
                "parent": "dfh:root",
            }
            adv_path.write_text(
                json.dumps(adv_obj, ensure_ascii=False, indent=4) + "\n",
                encoding="utf-8",
            )
            written_adv += 1

    # ---------- File D: ./data/dfh/tags/damage_type/sys/all.json ----------
    # Remove duplicates and keep stable ordering for version control diffs
    unique_sorted = sorted(set(all_strings))

    all_obj = {"values": unique_sorted}
    OUT_ALL_FILE.write_text(
        json.dumps(all_obj, ensure_ascii=False, indent=4) + "\n",
        encoding="utf-8",
    )

    print(f"Done. Source files: {len(src_files)}")
    print(f"Strings processed: {total_strings}")
    print(f"Unique strings in all.json: {len(unique_sorted)}")
    print(f"Tag JSON written: {written_tag}")
    print(f"MCFunction written: {written_mcf}")
    print(f"Advancement JSON written: {written_adv}")
    print(f"Written: {OUT_ALL_FILE.resolve()}")


if __name__ == "__main__":
    main()
