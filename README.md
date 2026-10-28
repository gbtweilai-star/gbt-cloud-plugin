# cloud_plugin

**One capability bit from GBT V8, packaged standalone.** No. 100 of 341,
`infra` domain (Infra).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 云插件（只读骨架）：**云源注册表 + 触手双向连接**。**无限扩容 = 加一行**（SOURCES 元组）—— 现登记 10 个云源（云卡触手 / 云电脑 / 云卡ComfyUI / 能源池 / 统一密钥网关 / 免费模型池 / H3mini / a1.art / LibTV / Tripo3D）。**绑定一次两个方向都查得到**，台账同 tentacle_bind（只增不删）。五原语各自标清**可逆性/花费/是否卡门**。五条红线（密钥DPAPI/先算账再花钱/每次留痕/不绕官方入口/身份内核不变）。op=status/sources/primitives/ledger/bind/resolve/expand/check_key/check_bill/check_bypass/check_trace

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-cloud-plugin.git
cd gbt-cloud-plugin
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_cloud_plugin info                  # capability card
python -m gbt_cloud_plugin spec --json           # machine-readable contract
python -m gbt_cloud_plugin check --payload '{}'
python -m gbt_cloud_plugin run   --payload '{}'
```

Real `info` output from this machine:

```text
cloud_plugin  (infra)  v1.0.0
----------------------------------------
云插件（只读骨架）：**云源注册表 + 触手双向连接**。**无限扩容 = 加一行**（SOURCES 元组）—— 现登记 10 个云源（云卡触手 / 云电脑 / 云卡ComfyUI / 能源池 / 统一密钥网关 / 免费模型池 / H3mini / a1.art / LibTV / Tripo3D）。**绑定一次两个方向都查得到**，台账同 tentacle_bind（只增不删）。五原语各自标清**可逆性/花费/是否卡门**。五条红线（密钥DPAPI/先算账再花钱/每次留痕/不绕官方入口/身份内核不变）。op=status/sources/primitives/ledger/bind/resolve/expand/check_key/check_bill/check_bypass/check_trace

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : status, sources, primitives, ledger, bind, resolve, expand, check_key, check_bill, check_bypass, check_trace
```

Wire a real implementation:

```python
from gbt_cloud_plugin import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（11 个）**：`status`、`sources`、`primitives`、`ledger`、`bind`、`resolve`、`expand`、`check_key`、`check_bill`、`check_bypass`、`check_trace`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.12s
```

## Provenance

| field | value |
|---|---|
| capability | `cloud_plugin` |
| domain | `infra` |
| handler | `cloud_plugin` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [infra/cloud_plugin](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/infra/cloud_plugin.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
