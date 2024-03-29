// Copyright (c) HashiCorp, Inc.
// SPDX-License-Identifier: MPL-2.0

//go:generate packer-sdc struct-markdown

package common

import (
	"github.com/hashicorp/packer-plugin-sdk/template/interpolate"
)

type DiskConfig struct {
	// The size(s) of any additional
	// hard disks for the VM in megabytes. If this is not specified then the VM
	// will only contain a primary hard disk. The builder uses expandable, not
	// fixed-size virtual hard disks, so the actual file representing the disk will
	// not use the full size unless it is full.
	AdditionalDiskSize []uint `mapstructure:"disk_additional_size" required:"false"`
	// The adapter type of the VMware virtual disk to create. This option is
	// for advanced usage, modify only if you know what you're doing. Some of
	// the options you can specify are `ide`, `sata`, `nvme` or `scsi` (which
	// uses the "lsilogic" scsi interface by default). If you specify another
	// option, Packer will assume that you're specifying a `scsi` interface of
	// that specified type. For more information, please consult [Virtual Disk
	// Manager User's Guide](http://www.vmware.com/pdf/VirtualDiskManager.pdf)
	// for desktop VMware clients. For ESXi, refer to the proper ESXi
	// documentation.
	DiskAdapterType string `mapstructure:"disk_adapter_type" required:"false"`
	// The filename of the virtual disk that'll be created,
	// without the extension. This defaults to "disk".
	DiskName string `mapstructure:"vmdk_name" required:"false"`
	// The type of VMware virtual disk to create. This
	// option is for advanced usage.
	//
	//   For desktop VMware clients:
	//
	//   Type ID | Description
	//   ------- | ---
	//   `0`     | Growable virtual disk contained in a single file (monolithic sparse).
	//   `1`     | Growable virtual disk split into 2GB files (split sparse).
	//   `2`     | Preallocated virtual disk contained in a single file (monolithic flat).
	//   `3`     | Preallocated virtual disk split into 2GB files (split flat).
	//   `4`     | Preallocated virtual disk compatible with ESX server (VMFS flat).
	//   `5`     | Compressed disk optimized for streaming.
	//
	//   The default is `1`.
	//
	//   For ESXi, this defaults to `zeroedthick`. The available options for ESXi
	//   are: `zeroedthick`, `eagerzeroedthick`, `thin`. `rdm:dev`, `rdmp:dev`,
	//   `2gbsparse` are not supported. Due to default disk compaction, when using
	//   `zeroedthick` or `eagerzeroedthick` set `skip_compaction` to `true`.
	//
	//   For more information, please consult the [Virtual Disk Manager User's
	//   Guide](https://www.vmware.com/pdf/VirtualDiskManager.pdf) for desktop
	//   VMware clients. For ESXi, refer to the proper ESXi documentation.
	DiskTypeId string `mapstructure:"disk_type_id" required:"false"`
}

func (c *DiskConfig) Prepare(ctx *interpolate.Context) []error {
	var errs []error

	if c.DiskName == "" {
		c.DiskName = "disk"
	}

	if c.DiskAdapterType == "" {
		// Default is lsilogic
		c.DiskAdapterType = "lsilogic"
	}

	return errs
}
